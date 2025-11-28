### 🚀 Building a Fully Automated Cloud Deployment CI/CD Pipeline: GitHub Actions + Terraform + AWS EC2

This project demonstrates how I built an end-to-end automated cloud deployment pipeline that provisions an EC2 instance on AWS using Infrastructure as Code and CI/CD automation with GitHub Actions and Terraform.

Every push to my main branch automatically deploys an EC2 instance in Amazon Web Services using AWS EC2.


### 🗂️ Created the GitHub Actions Workflow Structure
From my local bash terminal inside my project directory, I ran:

```
mkdir .github
cd .github
mkdir workflows
cd workflows
touch EC2deploy.yml
```
This created the required GitHub Actions structure:

```
.github/workflows/EC2deploy.yml
```

### 🛠️ Built My CI/CD Pipeline YAML File
I opened the workflow file using Visual Studio Code to ensure proper YAML formatting:
```
code EC2deploy.yml
```
Then I added my pipeline configuration:
```
name: Deploy EC2 with Terraform

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.5.0

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ secrets.AWS_REGION }}

      - name: Terraform Init
        run: terraform init

      - name: Terraform Fmt
        run: terraform fmt

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        run: terraform plan

      - name: Terraform Apply
        run: terraform apply -auto-approve
```

### 📄 Created My Terraform Configuration Files

From the root of my project:
```
touch provider.tf
touch EC2instance.tf
code provider.tf
code EC2instance.tf
```

### Provider.tf
```
provider "aws" {
  region = "us-west-1"
}
```
### EC2instance.tf
```
resource "aws_instance" "Terraform-CICD" {
  ami           = "ami-0e6a50b0059fd2cc3"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-CICD"
  }
}
```

### 🖥️ Selected the Correct AMI from AWS
Inside the AWS Console:

1. Navigated to EC2 → Launch Instance
2. Selected the Ubuntu AMI
3. Copied the AMI ID 
4. Pasted it into my EC2instance.tf file

This ensured correct deployment in the selected AWS region.

### 🔐 Securely Configured GitHub Repository Secrets

In my GitHub repository:

1. Went to Settings → Secrets and variables → Actions
2. Added:
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
```
To locate my credentials locally:
```
cd ~/.aws
cat credentials
```
No secrets were hardcoded.

### 📦 Staged, Committed, and Pushed My Code
```
git status
git add .
git commit -m "EC2 instance Deploy"
git push
```
Once the push completed, GitHub Actions automatically triggered the pipeline.

### ⚙️ My CI/CD Pipeline Executed Automatically

The workflow performed the following:
1. Checked out the code
2.  Installed Terraform
3.  Authenticated securely with AWS
4.  Ran:
- terraform init
- terraform fmt
- terraform validate
- terraform plan
- terraform apply

The EC2 instance was deployed with zero manual intervention. 

### 🔍 Verified the EC2 Deployment in AWS

In the AWS Console:

1. Navigated to EC2 → Instances
2. Confirmed the instance named Terraform-CICD was running 

This verified that the full CI/CD automation worked end-to-end.

### 🏁 Conclusion

This project demonstrates my ability to design, automate, and securely deploy cloud infrastructure using real-world DevOps tools and CI/CD best practices. 
