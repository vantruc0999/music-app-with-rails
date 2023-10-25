# Use the official Ruby image
FROM ruby:3.2.2

# Set the working directory in the container
# WORKDIR /var/www
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install dependencies using Bundler
RUN bundle install

# Copy the rest of the application code to the container
COPY . .

# Expose the Rails application's port (typically 3000)
EXPOSE 3000

# Start the Rails application
CMD ["rails", "server", "-b", "0.0.0.0"]
# CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
