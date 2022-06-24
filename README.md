# invalidate-cloudfront-and-wait-for-completion-action

A GitHub Workflow Action which invalidates Cloudfront distribution paths and wait for the completion.

## Usage

The sample workflow.

```yaml
name: Invalidate Cloudfront Distribution and Wait for Completion
on: push

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: checkout
      uses: actions/checkout@master

    - name: invalidate cloudfront distribution and wait for completion
      uses: muratiger/invalidate-cloudfront-and-wait-for-completion-action@master
      env:
        DISTRIBUTION_ID: ${{ secrets.DISTRIBUTION_ID }}
        PATHS: '/*'
        AWS_REGION: 'us-east-1'
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

### AWS IAM Policy

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                 "cloudfront:CreateInvalidation",
                 "cloudfront:GetInvalidation"
             ],
            "Resource": "arn:aws:cloudfront::<account id>:distribution/*"
        }
    ]
}
```
