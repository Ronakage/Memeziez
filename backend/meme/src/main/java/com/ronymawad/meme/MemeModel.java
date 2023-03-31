package com.ronymawad.meme;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class MemeModel {
    @Id
    @SequenceGenerator(
            name = "meme_id_sequence",
            sequenceName = "meme_id_sequence"
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "meme_id_sequence"
    )
    private Integer id;
    private Integer creatorId;
    @Lob
    @Type(type = "org.hibernate.type.BinaryType")
    private byte[] data;
    private LocalDateTime createdAt;
    @OneToMany(cascade = {CascadeType.ALL})
    private List<LikeModel> likes;
    @OneToMany(cascade = {CascadeType.ALL})
    private List<CommentModel> comments;
}
