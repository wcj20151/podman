# Use a suitable base image, e.g., Fedora or Ubuntu
FROM fedora:latest

# Define environment variables for the database and user
ENV DB_USER=pguser
ENV DB_HOME=/var/lib/postgresql/data

# 1. Install the database software (example for PostgreSQL)
# Commands vary based on the specific database
RUN dnf install -y postgresql-server postgresql-contrib && \
    dnf clean all

# 2. Create a dedicated system user and group (if not created by the package manager)
# The package manager often creates the user, e.g., 'postgres'
# If manual creation is needed:
# RUN groupadd -r pguser && useradd -r -g pguser -s /bin/bash pguser

# 3. Create the volume directory and set ownership during the build
# The directory must be owned by the non-root user that will run the database service
RUN mkdir -p ${DB_HOME} && \
    chown -R ${DB_USER}:${DB_USER} ${DB_HOME}

# 4. Initialize the database during the build (optional, often done at runtime)
# This step prepares the data directory
RUN postgresql-setup initdb

# 5. Specify the volume mount point in the image
# This informs Podman/Docker that this directory is intended for external mounting
VOLUME ${DB_HOME}

# 6. Switch to the non-root user for subsequent operations and runtime
USER ${DB_USER}

# 7. Expose the default database port (example for PostgreSQL)
EXPOSE 5432

# 8. Define the command to run when the container starts
CMD ["postgres"]
