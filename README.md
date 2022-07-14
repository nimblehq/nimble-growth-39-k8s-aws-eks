# AWS EKS

For Nimble Growth 39 session - AWS EKS practice.

## Usage

1. Clone the repository

```bash
  git clone git@github.com:nimblehq/nimble-growth-39-k8s-aws-eks.git
```

2. Login to Terraform Cloud

```bash
terraform login

[Enter the Token from 1PassWord]
```

3. Cd to the `terraform` folder

4. `terraform init`

5. `terraform plan`

## Adjust the `codewar` application to support Elixir Cluster

1. Clone the CodeWar application `https://github.com/nimblehq/codewar-web`

2. Checkout a new branch from the `chore/nimble-growth-39-push-to-ecr-workflow` branch.

3. Modify the codebase

4. Push the changes and trigger the `https://github.com/nimblehq/codewar-web/actions/workflows/push-to-ecr.yml` workflow.

## License

This project is Copyright (c) 2014 and onwards Nimble. It is free software and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
