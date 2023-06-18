# Use the official Hugo Docker image as the base image
FROM klakegg/hugo:ext-alpine

# Set the working directory inside the container
WORKDIR /site

# Copy the source code of the Hugo website to the container
COPY . /site

# Add the following lines to sync and update the Git submodules
RUN git submodule sync --recursive && \
    git submodule update --init --recursive

# Build the Hugo static website
RUN hugo --minify --verbose

# Use a lightweight web server to serve the static website
FROM nginx:alpine

# Copy the generated static files from the previous stage to the Nginx server's web root directory
COPY --from=0 /site/public /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# Start the Nginx server when the container starts
CMD ["nginx", "-g", "daemon off;"]
