export interface BaseResponse<T> {
  success: boolean
  data: T | null
  error: string | null
  meta: {
    total: number
  }
}

export interface PaginationResponse<T> {
  success: boolean
  data: T[]
  error: string | null
  meta: {
    total: number
    current_page: number
    per_page: number
  }
}
