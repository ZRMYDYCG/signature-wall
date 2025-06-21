export interface SearchResponse<T> {
  success: boolean
  data: T | null
  error: string | null
  meta: {
    total: number
  }
}
