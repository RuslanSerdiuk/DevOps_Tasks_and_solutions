############################
# Storage                  #
############################
output "Storage_Bucket_ID" {
  value = google_storage_bucket.bucket_for_bst_infrastrucure_state_files.id
}
