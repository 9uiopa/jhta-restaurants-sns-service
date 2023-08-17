package kr.co.jhta.restaurants_service.vo.socials;


import kr.co.jhta.restaurants_service.repository.composites.FollowCompositePrimaryKeys;
import org.apache.ibatis.type.Alias;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

@Alias("Follows")
@Entity
@Table(name = "FOLLOWS")
public class Follow {

	@EmbeddedId
	private FollowCompositePrimaryKeys compositePrimaryKeys;

	@CreatedDate
	@Column(name = "create_date")
	private Date createDate;

	public Follow() {
		this.createDate = new Date();
	}

	public FollowCompositePrimaryKeys getCompositePrimaryKeys() {
		return compositePrimaryKeys;
	}

	public void setCompositePrimaryKeys(FollowCompositePrimaryKeys compositePrimaryKeys) {
		this.compositePrimaryKeys = compositePrimaryKeys;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
}
