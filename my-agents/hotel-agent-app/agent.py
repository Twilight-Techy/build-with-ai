from google.adk.agents import Agent
from google.adk.tools.toolbox_tool import ToolboxTool

toolbox = ToolboxTool("http://127.0.0.1:5000")

# Load single tool
# tools = toolbox.get_tool(tool_name='search-hotels-by-location'),
# Load all the tools
tools = toolbox.get_toolset(toolset_name='my_first_toolset')

root_agent = Agent(
    name="hotel_agent",
    model="gemini-2.0-flash",
    description=(
        "Agent to answer questions about hotels in a city or hotels by name."
    ),
    instruction=(
        "You are a helpful agent who can answer user questions about the hotels in a specific city or hotels by name. Use the tools to answer the question"
    ),
    tools=tools,
)