import os
import json
from datetime import datetime, timezone, timedelta

import functions_framework
from google.cloud import logging
import requests

DEFAULT_LOGS = {
    "security": """
2023-04-01 09:15:27.123 ERROR Failed login attempt from IP 198.51.100.123: Invalid credentials
2023-04-01 09:15:29.456 CRITICAL Multiple failed login attempts detected: Possible brute force attack
2023-04-01 09:16:00.789 ERROR Unauthorized access attempt to /admin endpoint
""",
    "dev": """
2023-04-01 10:15:27.123 ERROR Uncaught TypeError: Cannot read property 'data' of undefined at UserService.getUser
2023-04-01 10:15:29.456 ERROR API rate limit exceeded for endpoint /api/users
2023-04-01 10:16:00.789 CRITICAL Application crashed: Out of memory exception in worker thread
""",
    "database": """
2023-04-01 11:15:27.123 ERROR Failed to connect to database: Connection refused
2023-04-01 11:15:29.456 CRITICAL Database deadlock detected in transaction #45982
2023-04-01 11:16:00.789 ERROR Query performance degradation: Full table scan on users_table
"""
}

MODE_PROMPTS = {
    "security": "You are a security analyst in a SOC (Security Operations Center). Review these logs from a security perspective. First provide a clear SUMMARY of what happened. Then under ATTACK PATTERNS, identify and explain potential security threats, unauthorized access attempts, suspicious activities, and attack vectors. Finally, under IMPACT ASSESSMENT, evaluate the potential impact and provide specific, actionable recommendations to improve security posture.",
    
    "dev": "You are a developer analyzing application logs. Review these logs from an application development perspective. First provide a clear SUMMARY of what happened. Then under ERROR ANALYSIS, identify software bugs, performance issues, error patterns, or application failures. Finally, under IMPACT ASSESSMENT, evaluate the impact on the application and provide specific, actionable recommendations to improve code quality and application reliability.",
    
    "database": "You are a database administrator. Review these logs from a database management perspective. First provide a clear SUMMARY of what happened. Then under PERFORMANCE ANALYSIS, identify database connectivity issues, query problems, or performance bottlenecks. Finally, under IMPACT ASSESSMENT, evaluate the impact on database operations and provide specific, actionable recommendations to improve database health and performance."
}

@functions_framework.http
def logs_story(request):
    """HTTP Cloud Function that returns a Gemini-generated story based on logs."""
    # Parse request parameters
    request_json = request.get_json(silent=True)
    request_args = request.args
    
    # Get parameters with defaults
    if request_json and 'timeframe' in request_json:
        timeframe = int(request_json['timeframe'])
    elif request_args and 'timeframe' in request_args:
        timeframe = int(request_args['timeframe'])
    else:
        timeframe = 1  # Default to 1 hour

    if request_json and 'mode' in request_json:
        mode = request_json['mode'].lower()
    elif request_args and 'mode' in request_args:
        mode = request_args['mode'].lower()
    else:
        mode = "dev"  # Default to dev mode
    
    # Initialize logging client
    logging_client = logging.Client()
        
    # Query logs from the past X hours with severity ERROR or higher
    now = datetime.now(timezone.utc)
    time_ago = now - timedelta(hours=timeframe)
    time_iso = time_ago.isoformat()  # e.g. "2023-04-01T08:30:00+00:00"
    
    log_filter = f'severity >= ERROR AND timestamp >= "{time_iso}"'
    
    try:
        entries = logging_client.list_entries(filter_=log_filter)
        
        logs_text = ""
        entry_count = 0
        
        for entry in entries:
            entry_count += 1
            # Format the log entry properly
            if hasattr(entry, "timestamp"):
                timestamp = entry.timestamp.isoformat()
            else:
                timestamp = "Unknown time"
                
            severity = entry.severity if hasattr(entry, "severity") else "ERROR"
            
            if hasattr(entry, "payload"):
                message = str(entry.payload)
            else:
                message = str(entry)
            
            logs_text += f"{timestamp} {severity} {message}\n"
            
            # Limit to reasonable number of entries to avoid excessive API costs
            if entry_count >= 50:
                logs_text += "... (additional logs truncated) ...\n"
                break
                
        # If no logs were collected, use the default sample logs
        if not logs_text.strip():
            logs_text = DEFAULT_LOGS.get("dev", DEFAULT_LOGS["dev"])
            logs_text = logs_text.strip()
        
        return (f"Found {entry_count} log entries: \n\n{logs_text}", 200)
    
    except Exception as e:
        return (f"Error querying logs: {str(e)}", 500)