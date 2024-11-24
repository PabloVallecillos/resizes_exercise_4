FROM rust:latest
# Set the working directory inside the container
WORKDIR /app
COPY Cargo.toml ./Cargo.toml
COPY src/main.rs ./src/main.rs
RUN cargo build --release
FROM debian:bookworm-slim
WORKDIR /app
# Copy the compiled binary from the builder stage
COPY --from=0 /app/target/release/rust-app .
ENTRYPOINT ["./rust-app"]
