package com.ronymawad.meme;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MemeRepository extends JpaRepository<MemeModel, Integer> {
}
