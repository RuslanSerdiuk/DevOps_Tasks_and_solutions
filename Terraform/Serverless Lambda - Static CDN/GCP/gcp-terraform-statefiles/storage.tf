#####################################################################
# Create a Storage Bucket to store the state file in                #
#####################################################################
resource "google_storage_bucket" "bucket_for_bst_infrastrucure_state_files" {
 name          = var.storage_bucket_name
 location      = var.location
 storage_class = var.storage_class

 public_access_prevention = "enforced"
 versioning {
  enabled = true
 }
}
