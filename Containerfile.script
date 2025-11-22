FROM ubuntu:latest

# Create a directory named 'app'
RUN mkdir /app

# Set the working directory to '/app'
WORKDIR /app

# Copy 'my_script.sh' from the host to '/app' in the container
COPY my_script.sh .

# Make the script executable
RUN chmod +x my_script.sh

# Run the script when the container starts
CMD ["./my_script.sh"]
