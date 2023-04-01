package com.ronymawad.meme;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class LikeModel {
    @Id
    @SequenceGenerator(
            name = "like_id_sequence",
            sequenceName = "like_id_sequence"
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "like_id_sequence"
    )
    private Integer id;

    private Integer likerId;

    private String likerUsername;

    private LocalDateTime likedAt;

}
