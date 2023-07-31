package kr.co.jhta.restaurants_service.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Review {

	private int id;
	private double rating;
	private String content;
	private Date createDate;
	private Date updateDate;
	private int recommendCount;
	private Customer customer;
	private Store store;
	
	
}
