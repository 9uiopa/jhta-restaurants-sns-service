package kr.co.jhta.restaurants_service.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("PostPicture")
public class PostPicture {

	private int id;
	private String pictureName;
	private Post post;

}
