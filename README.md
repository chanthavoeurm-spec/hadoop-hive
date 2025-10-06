# hadoop-hive
These repositories are not “official,” but are good learning or example projects that combine Hadoop and Hive (and often other tools). Useful if you want to see practical usage, coding style, and data workflows.

---

## Full Stack: Hadoop, Hive, Hive Metastore, Postgres, Pig

This project provides a modern Docker Compose stack for big data experimentation and learning. It includes:
- **Hadoop**: Distributed storage and processing
- **Hive**: Data warehouse infrastructure
- **Hive Metastore**: Metadata service for Hive, backed by Postgres
- **Postgres**: Database for Hive metadata
- **Pig**: Platform for analyzing large data sets

All services are containerized and networked for seamless integration.

---

## How to Use

### Prerequisites
- Docker
- Docker Compose

### Quick Start
1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd hadoop-hive
   ```
2. Start the stack:
   ```bash
   docker-compose up
   ```
   This will build and start all services: Hadoop, Hive, Hive Metastore, Postgres, and Pig.

3. Access service ports:
   - Hadoop HDFS UI: [localhost:9870](http://localhost:9870)
   - YARN ResourceManager: [localhost:8088](http://localhost:8088)
   - HiveServer2: localhost:10000
   - Hive Metastore: localhost:9083
   - Postgres: localhost:5432

### Service Details
- **Hadoop**: Provides HDFS and YARN. Used by Hive and Pig for storage and processing.
- **Postgres**: Stores Hive metadata. Credentials are set in `docker-compose.yml`.
- **Hive Metastore**: Connects to Postgres and provides metadata services for Hive.
- **Hive Server**: Connects to Hive Metastore and Hadoop for SQL-like queries.
- **Pig**: Connects to Hadoop for data analysis workflows.

### Custom Configuration
- You can add custom configuration files for Hadoop, Hive, Pig, or Postgres in the `config/` directory (if needed).
- Environment variables for each service can be adjusted in `docker-compose.yml`.

### Stopping the Stack
```bash
  docker-compose down
```

---

## Troubleshooting
- Ensure Docker and Docker Compose are installed and running.
- If ports are busy, change them in `docker-compose.yml`.
- For logs and debugging, use:
  ```bash
  docker-compose logs <service-name>
  ```

---

## References
- [Hadoop](https://hadoop.apache.org/)
- [Hive](https://hive.apache.org/)
- [Pig](https://pig.apache.org/)
- [Postgres](https://www.postgresql.org/)
- [bde2020 Docker images](https://github.com/big-data-europe/docker-hadoop)

---

## License
This project is for educational purposes only.
