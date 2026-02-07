package com.example.ayurlink.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "treatments")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Treatment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Treatment name is required")
    @Size(min = 2, max = 100, message = "Treatment name must be between 2 and 100 characters")
    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @NotNull(message = "Cost is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Cost must be greater than 0")
    @Column(nullable = false)
    private Double cost;

    @Positive(message = "Duration must be a positive number")
    private Integer duration; // in minutes

    private String image;

    @Size(max = 500, message = "Suitable for must not exceed 500 characters")
    @Column(name = "suitable_for")
    private String suitableFor; // e.g., "Back Pain, Stress Relief"

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "is_active")
    private Boolean isActive = true;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

}