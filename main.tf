provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "eks_subnet_a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "eks_subnet_b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_eks_cluster" "my_eks" {
  name     = "my-k8s-cluster"
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = [aws_subnet.eks_subnet_a.id, aws_subnet.eks_subnet_b.id]
  }
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name  = aws_eks_cluster.my_eks.name
  node_role_arn = aws_iam_role.eks_role.arn
  subnet_ids    = [aws_subnet.eks_subnet_a.id, aws_subnet.eks_subnet_b.id]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}

output "eks_cluster_name" {
  value = aws_eks_cluster.my_eks.name
}
