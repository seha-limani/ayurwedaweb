package com.example.ayurlink.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "patients")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@PrimaryKeyJoinColumn(name = "user_id")
public class Patient extends User {


    @Column(nullable = false, unique = true)
    private String nic;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Size(max = 255, message = "Address must not exceed 255 characters")
    private String address;



    private Integer age;

    @Enumerated(EnumType.STRING)
    private Gender gender;

    @Column(name = "medical_history", columnDefinition = "TEXT")
    private String medicalHistory;

}



