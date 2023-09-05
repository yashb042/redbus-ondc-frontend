docker network inspect ondc-network --format {{.Id}} 2>/dev/null || docker network create ondc-network
if [ "$NODE_ENV" = "DEVELOPMENT" ]; then
    ENV_FILE="local.env"
else
    ENV_FILE="prod.env"
fi
docker build -t mobility-sample-bap:latest .
docker stop mobility-sample-bap || true && docker rm mobility-sample-bap || true

docker run --network=ondc-network -p 2010:2010 --name mobility-sample-bap --env-file "$ENV_FILE" -d mobility-sample-bap:latest
