package com.library.util;

import java.util.ArrayList;
import java.util.List;

public class PaginationHelper {
    
    public static <T> List<T> getPage(List<T> items, int page, int pageSize) {
        if (items == null || items.isEmpty()) {
            return new ArrayList<T>();
        }
        
        int totalItems = items.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        // Validate page number
        if (page < 1) {
            page = 1;
        } else if (page > totalPages) {
            page = totalPages;
        }
        
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalItems);
        
        if (startIndex >= totalItems) {
            return new ArrayList<T>();
        }
        
        return items.subList(startIndex, endIndex);
    }
    
    public static int getTotalPages(int totalItems, int pageSize) {
        return (int) Math.ceil((double) totalItems / pageSize);
    }
    
    public static boolean hasPrevious(int currentPage) {
        return currentPage > 1;
    }
    
    public static boolean hasNext(int currentPage, int totalPages) {
        return currentPage < totalPages;
    }
}