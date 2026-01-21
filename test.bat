# Run PostgreSQL on the network
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v ny_taxi_postgres_data:/var/lib/postgresql \
  -p 5432:5432 \
  --network=pg-network \
  --name pgdatabase \
  postgres:18

# In another terminal, run pgAdmin on the same network
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -v pgadmin_data:/var/lib/pgadmin \
  -p 8085:80 \
  --network=pg-network \
  --name pgadmin \
  dpage/pgadmin4



docker run -it --rm \
      taxi_ingest:v001 \
    --network=pg-network \
    --pg_user=root \
    --pg_password=root \
    --pg_host=pgdatabase \
    --pg_port=5432 \
    --pg_db=ny_taxi \
    --target_table=yellow_taxi_trips_2021_1 \
    --chunksize=100000
