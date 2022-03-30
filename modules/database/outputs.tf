output "ClusterName" {
  value = aws_rds_cluster.Casestudydatabase-cluster.database_name
}

output "reader-cluster-endpoint" {
  value = aws_rds_cluster.Casestudydatabase-cluster.reader_endpoint
}

output "writer-cluster-endpoint" {
  value = aws_rds_cluster.Casestudydatabase-cluster.endpoint
}

output "cache-endpoint" {
  value = aws_elasticache_cluster.elasticcache-casestudy.configuration_endpoint
}