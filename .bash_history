gcloud services enable cloudfunctions.googleapis.com
gcloud services enable logging.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable artifactregistry.googleapis.com
gcloud services enable aiplatform.googleapis.com
mkdir what-logs-say
cd what-logs-say
cat > requirements.txt << 'EOL'
google-cloud-logging>=3.1.0
requests>=2.28.0
functions-framework>=3.0.0
EOL

PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")
SERVICE_ACCOUNT_NAME="cf-builder"
SERVICE_ACCOUNT_EMAIL="$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com"
gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME   --display-name "Cloud Functions Build Service Account"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL"   --role="roles/cloudbuild.builds.builder"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL"   --role="roles/artifactregistry.writer"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL"   --role="roles/logging.logWriter"
gcloud projects add-iam-policy-binding $PROJECT_ID   --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL"   --role="roles/cloudfunctions.developer"
gcloud functions deploy what-logs-say   --runtime python310   --trigger-http   --allow-unauthenticated   --entry-point logs_story   --set-env-vars GEMINI_API_KEY=YOUR_API_KEY   --service-account $SERVICE_ACCOUNT_EMAIL
cd what-logs-say
gcloud functions deploy what-logs-say   --runtime python310   --trigger-http   --allow-unauthenticated   --entry-point logs_story   --set-env-vars GEMINI_API_KEY=YOUR_API_KEY   --service-account $SERVICE_ACCOUNT_EMAIL
chmod +x generate_logs.py
python generate_logs.py hacking --count 50
echo "Waiting for logs to be available..."
sleep 120
FUNCTION_URL=$(gcloud functions describe what-logs-say --format="value(httpsTrigger.url)")
echo "Function URL: $FUNCTION_URL"
FUNCTION_URL=$(gcloud functions describe what-logs-say --format="value(httpsTrigger.url)")
echo "Function URL: $FUNCTION_URL"
FUNCTION_URL=$(gcloud functions describe what-logs-say --format="value(httpsTrigger.url)")
echo "Function URL: $FUNCTION_URL"
echo "Testing security analysis mode..."
curl "$FUNCTION_URL?mode=security&timeframe=2"
FUNCTION_URL=$(gcloud functions describe what-logs-say --format="value(httpsTrigger.url)")
echo "Function URL: $FUNCTION_URL"
gcloud functions list
gcloud functions describe what-logs-say --format="value(httpsTrigger.url)" --verbosity=debug
gcloud config set core/disable_prompts True  # Temporarily disable prompts
gcloud config unset project  # Unset the project
gcloud config set project build-with-ai-2025-458710 # Set the project again
gcloud config set core/disable_prompts False # Re-enable prompts
gcloud functions describe what-logs-say --region=us-central1 --format="value(httpsTrigger.url)"
echo "Function URL: $FUNCTION_URL"
FUNCTION_URL=$(gcloud functions describe what-logs-say --format="value(httpsTrigger.url)")
echo "Function URL: $FUNCTION_URL"
curl "$FUNCTION_URL?mode=security&timeframe=2"
FUNCTION_URL=$(gcloud functions describe what-logs-say --format="value(httpsTrigger.url)")
echo "Function URL: $FUNCTION_URL"
curl "$FUNCTION_URL?mode=security&timeframe=2"
gcloud auth list
gcloud config list project
gcloud services enable cloudresourcemanager.googleapis.com                        servicenetworking.googleapis.com                        run.googleapis.com                        cloudbuild.googleapis.com                        cloudfunctions.googleapis.com                        aiplatform.googleapis.com                        sqladmin.googleapis.com                        compute.googleapis.com 
gcloud sql instances create hoteldb-instance --database-version=POSTGRES_15 --cpu=2 --memory=8GiB --region=us-central1 --edition=ENTERPRISE --root-password=postgres
mkdir mcp-toolbox
cd mcp-toolbox
export VERSION=0.3.0
curl -O https://storage.googleapis.com/genai-toolbox/v$VERSION/linux/amd64/toolbox
chmod +x toolbox
touch tools.yaml
./toolbox --tools-file "tools.yaml"
cd mcp-toolbox
./toolbox --tools-file "tools.yaml"
mkdir my-agents
cd my-agents
python -m venv .venv
source .venv/bin/activate
adk
pip install google-adk toolbox-langchain langchain
adk
adk create hotel-agent-app
ls -la
cd my-agents/hotel-agent-app
ls -la
cd ../my-agents/hotel-agent-app
ls -la
cd ..
adk web
awk run hotel-agent-app
adk run hotel-agent-app
./toolbox --tools_file "tools.yaml"
./toolbox --tools_file "tools.yaml"
gcloud functions describe what-logs-say
FUNCTION_URL=$(gcloud functions describe what-logs-say | grep 'url:' | awk '{print $2}')
echo $FUNCTION_URL
echo "Function URL: $FUNCTION_URL"
echo "Testing security analysis mode..."
curl "$FUNCTION_URL?mode=security&timeframe=2"
gcloud functions update what-logs-say   --set-env-vars GEMINI_API_KEY="gcloud functions update what-logs-say \
  --set-env-vars GEMINI_API_KEY="YOUR_ACTUAL_GEMINI_API_KEY"AIzaSyBpuX5sLSptO0rbUF1Z9xqAg6vWiULC3Ns"
gcloud functions update what-logs-say   --set-env-vars GEMINI_API_KEY="AIzaSyBpuX5sLSptO0rbUF1Z9xqAg6vWiULC3Ns"
gcloud --version
Google Cloud SDK 519.0.0
alpha 2025.04.18
app-engine-go 1.9.76
app-engine-java 2.0.34
app-engine-python 1.9.114
app-engine-python-extras 1.9.107
beta 2025.04.18
bigtable 
bq 2.1.15
bundled-python3-unix 3.12.8
cbt 1.23.1
cloud-datastore-emulator 2.3.1
cloud-run-proxy 0.5.0
core 2025.04.18
gcloud-crc32c 1.0.0
gke-gcloud-auth-plugin 0.5.10
gsutil 5.34
kpt 1.0.0-beta.55
kubectl 1.31.6
local-extract 1.6.2
minikube 1.35.0
nomos 1.20.3-rc.1
package-go-module 1.0.0
pubsub-emulator 0.8.19
skaffold 2.15.0gcloud --version
CLS
gcloud functions update what-logs-say   --region=us-central1   --set-env-vars GEMINI_API_KEY="AIzaSyBpuX5sLSptO0rbUF1Z9xqAg6vWiULC3Ns"
gcloud functions deploy what-logs-say   --region=us-central1   --set-env-vars=GEMINI_API_KEY="AIzaSyBpuX5sLSptO0rbUF1Z9xqAg6vWiULC3Ns"   --runtime=nodejs20   --trigger-http   --entry-point=yourFunctionName
gcloud functions deploy what-logs-say   --region=us-central1   --set-env-vars=GEMINI_API_KEY="AIzaSyBpuX5sLSptO0rbUF1Z9xqAg6vWiULC3Ns"   --project=build-with-ai-2025-458710
cd what-logs-say
gcloud functions deploy what-logs-say   --region=us-central1   --set-env-vars=GEMINI_API_KEY="AIzaSyBpuX5sLSptO0rbUF1Z9xqAg6vWiULC3Ns"   --project=build-with-ai-2025-458710
echo "Testing security analysis mode..."
curl "$FUNCTION_URL?mode=security&timeframe=2"
FUNCTION_URL=$(gcloud functions describe what-logs-say | grep 'url:' | awk '{print $2}')
echo "Function URL: $FUNCTION_URL"
echo "Testing security analysis mode..."
curl "$FUNCTION_URL?mode=security&timeframe=2"
echo "Asking about attack IPs..."
curl "$FUNCTION_URL?mode=security&timeframe=2&chat=What%20IP%20addresses%20were%20involved%20in%20the%20attack%3F"
echo "Asking about data exfiltration..."
curl "$FUNCTION_URL?mode=security&timeframe=2&chat=Was%20there%20evidence%20of%20data%20exfiltration%3F"
echo "Asking about attack methods..."
curl "$FUNCTION_URL?mode=security&timeframe=2&chat=What%20methods%20did%20the%20attacker%20use%20to%20gain%20access%3F"
gcloud auth list
gcloud config list project
gcloud services enable aiplatform.googleapis.com                            run.googleapis.com                            cloudbuild.googleapis.com                            cloudresourcemanager.googleapis.com
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
gcloud run deploy --source
gcloud run deploy --source .
git config --global user.name "Ibrahim Makanjuola"
git config --global user.email mzone7325@gmail.com
git update-ref -d HEAD
