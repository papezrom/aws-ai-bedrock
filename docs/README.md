# Documentation

This directory contains documentation and visual assets for the AWS AI Bedrock Content Approval Workflow project.

## Structure

```
docs/
├── images/
│   ├── deployment-architecture.png    # High-level deployment architecture
│   └── stepfunction-workflow.png      # Step Functions workflow visualization
└── README.md                          # This file
```

## Diagram Creation Guidelines

### Deployment Architecture Diagram
Create a comprehensive deployment architecture diagram showing:
- AWS regions and availability zones
- VPC and subnet configuration
- Lambda functions and their triggers
- Step Functions state machine
- S3 buckets and their relationships
- Bedrock agent integration
- EC2 Drupal instance with VPC connectivity
- CloudWatch and X-Ray monitoring flows
- IAM roles and security boundaries

**Recommended tools:**
- AWS Architecture Icons (official)
- Draw.io (free, AWS templates available)
- Lucidchart (professional)
- Cloudcraft (AWS-specific)

### Step Functions Workflow Diagram
Export the Step Functions workflow visualization directly from AWS Console:
1. Navigate to Step Functions in AWS Console
2. Select your state machine: `ContentApprovalWorkflow`
3. Go to "Definition" tab
4. Click "Graph view" 
5. Use browser screenshot or export functionality
6. Save as `stepfunction-workflow.png`

**Alternative:** Use the AWS Step Functions Workflow Studio to create a clean visual representation.

## Image Specifications
- **Format**: PNG (preferred) or SVG for scalability
- **Resolution**: Minimum 1920x1080 for detailed diagrams
- **File size**: Keep under 2MB for optimal GitHub loading
- **Naming**: Use kebab-case with descriptive names
- **Background**: Transparent or white background recommended
