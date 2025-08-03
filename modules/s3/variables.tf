variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "versioning" {
  description = "Enable versioning for the bucket (true for Enabled, false for Suspended)"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Whether to force-delete the bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "block_public_acls" {
  description = "Block public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public policies for the bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public buckets for the bucket"
  type        = bool
  default     = true
}

# Ownership Controls
variable "object_ownership" {
  description = "Ownership control for bucket objects (BucketOwnerPreferred, ObjectWriter)"
  type        = string
  default     = "BucketOwnerPreferred"
}

# Server-Side Encryption
variable "sse_algorithm" {
  description = "Encryption algorithm for bucket objects (AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "ID of the KMS key to use for encryption (if using aws:kms)"
  type        = string
  default     = ""
}

# Lifecycle Management
variable "lifecycle_enabled" {
  description = "Enable lifecycle configuration for the bucket"
  type        = bool
  default     = false
}

variable "lifecycle_prefix" {
  description = "Prefix for objects the lifecycle rule applies to"
  type        = string
  default     = ""
}

variable "lifecycle_expiration_days" {
  description = "Number of days after which objects will be expired"
  type        = number
  default     = 90
}

# Tags for Bucket
variable "tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default     = {}
}