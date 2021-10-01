variable "unit_prefix" {
    type = string
}

variable "actions" {
    type = list(string)
}

variable "tags" {
    type = map(string)
    default = {}
}