package com.ronymawad.meme;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MemeRepository extends JpaRepository<MemeModel, Integer> {
    List<MemeModel> findAllByCreatorId(Integer creatorId);
}
