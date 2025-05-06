variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group onde os recursos serão criados"
}

variable "location" {
  type        = string
  description = "Localização onde os recursos serão criados"
}

variable "lb_name" {
  type        = string
  description = "Nome do Load Balancer"
}

variable "lb_sku" {
  type        = string
  default     = "Standard"
  description = "SKU do Load Balancer (Basic ou Standard)"
}

variable "public_ip_name" {
  type        = string
  description = "Nome para o recurso de IP público"
}

variable "ip_sku" {
  type    = string
  default = "Standard"
}

variable "domain_name_label" {
  type        = string
  default     = ""
  description = "Label do DNS, se necessário (deixe em branco se não usar)"
}

variable "backend_pool_name" {
  type        = string
  description = "Nome para o backend address pool"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Mapeamento de tags para os recursos"
}

variable "probe_name" {
  type        = string
  default     = "http-probe"
  description = "Nome para o recurso de probe"
}

variable "probe_protocol" {
  type        = string
  default     = "Http"
  description = "Protocolo para o Health Probe"
}

variable "probe_port" {
  type        = number
  default     = 80
  description = "Porta para o Health Probe"
}

variable "probe_interval" {
  type        = number
  default     = 15
  description = "Intervalo (em segundos) entre as verificações de health probe"
}

variable "probe_count" {
  type        = number
  default     = 2
  description = "Número de tentativas antes de considerar a instância como não saudável"
}

variable "lb_rule_name" {
  type        = string
  default     = "lb-rule"
  description = "Nome da regra de Load Balancing"
}

variable "rule_protocol" {
  type        = string
  default     = "Tcp"
  description = "Protocolo para a regra do Load Balancer"
}

variable "frontend_port" {
  type        = number
  default     = 80
  description = "Porta de frontend exposta ao tráfego"
}

variable "backend_port" {
  type        = number
  default     = 80
  description = "Porta para encaminhamento ao backend"
}

variable "enable_floating_ip" {
  type        = bool
  default     = false
  description = "Habilitar Floating IP nas regras (para cenários específicos)"
}

variable "idle_timeout" {
  type        = number
  default     = 4
  description = "Tempo limite inativo em minutos"
}

variable "create_nat_rule" {
  type        = bool
  default     = false
  description = "Determina se uma regra NAT deve ser criada"
}

variable "nat_rule_name" {
  type        = string
  default     = "lb-nat-rule"
  description = "Nome da regra NAT"
}

variable "nat_frontend_port" {
  type        = number
  default     = 50000
  description = "Porta de frontend para a regra NAT"
}

variable "nat_backend_port" {
  type        = number
  default     = 22
  description = "Porta de backend para a regra NAT (por exemplo, para SSH)"
}
