# Real-Time Fraud Detection Dashboard

This repository contains the **infrastructure-as-code (IaC)** for a real-time fraud detection pipeline built on **AWS**, designed to simulate real-world scenarios by ingesting live social media data from Bluesky.

> **Note:** This repository includes only the Terraform and Terragrunt code for provisioning the infrastructure. The actual data processing scripts, SageMaker inference logic, and image automation pipeline are located in a separate repository .

---

## Project Highlights

- **Real-Time Fraud Detection:**  
  Utilizes Amazon Kinesis Data Streams and AWS Lambda for ingesting and transforming social media text, images, and video data in real-time.

- **Machine Learning Inference:**  
  Streams are routed to Amazon SageMaker models for live inference, detecting fraudulent patterns with sub-second latency — supporting up to 3,000 records per minute.

- **Data Persistence and Offline Analysis:**  
  Processed results and media assets are delivered to S3 in Parquet format for long-term storage and batch analytics.

- **Monitoring and Observability:**  
  Track real-time metrics, monitor pipeline health, and visualize dashboards for operational transparency.

- **Infrastructure Automation:**  
  Entire AWS infrastructure is provisioned and managed using Terraform and Terragrunt, with GitHub Actions enabling CI/CD pipelines for consistent, reproducible deployments.

---

## Example Dashboard Views
![Alt text](resources/dashboard-sample.png)

Dashboard view of 10% data streaming (for testing purpose)
![Alt text](resources/dashboard-sample-test-10.png)

## Repository Structure

This repository includes:

- Terragrunt-based IaC modules for:
  - VPC, Lambda, ECS, ECR, S3, Kinesis, Firehose, Glue, CloudWatch, and SageMakers
- Environments structured under `live/dev/`
- CI/CD automation via GitHub Actions (workflow files)

---

## Sensitive Information and Workflow Logs

- GitHub Actions workflows were intentionally **deleted after execution**. This is due to the possibility of **Terragrunt outputs exposing sensitive information** such as:
  - AWS Account ID
  - Resource ARNs (e.g., S3 buckets, Lambda functions)

While GitHub Actions provides masking capabilities, logs can still unintentionally reveal details through AWS error messages or infrastructure outputs.

---

## Decoupled Design: Infrastructure vs. Application Logic

This repo contains only the infrastructure code, while the application code is stored in a separate repository.

I chose to separate the infrastructure code from the application logic because it’s a best practice that improves maintainability and security. Keeping them apart makes testing and development simpler by isolating responsibilities, and it also allows the infrastructure to be reused across different projects

---

##  Requirements

- Terraform v1.12.1+
- Terragrunt v0.78+
- AWS CLI with appropriate IAM permissions

---

## Usage
- To deploy the infra, run Deploy the IaC in AWS workflow and configure proper secrets.
- To destroy the infra, run Destroy the IaC in AWS workflow and configure proper secrets.