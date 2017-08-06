package layers.dataaccess;

import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

/**
 * @author jhirschbeck
 */
@MappedSuperclass
public class PersistentObject {

    @Id
    private Long id;

    public boolean isNewlyCreated() {
        return this.id == null;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
