# Use an official Hugo image as the base image
FROM klakegg/hugo:ext

# Set the working directory
WORKDIR /src

# Copy the contents of the current directory to the working directory
COPY . .

# Add the following lines to sync and update the Git submodules
RUN git submodule sync --recursive && \
    git submodule update --init --recursive

# Expose the default Hugo server port
EXPOSE 1313

# Start the Hugo server
CMD ["server", "--bind", "0.0.0.0", "--port", "1313"]
