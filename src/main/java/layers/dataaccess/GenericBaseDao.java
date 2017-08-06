package layers.dataaccess;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

/**
 * @author jhirschb
 */
public class GenericBaseDao {

    @PersistenceContext
    protected EntityManager em;


    public <T_ENTITY extends PersistentObject> void save(T_ENTITY entity) {

        if (entity.isNewlyCreated()) {
            em.persist(entity);
        } else {
            em.merge(entity);
        }
    }

    public <T_ENTITY extends PersistentObject> void delete(T_ENTITY entity) {

        em.remove(entity);
    }

    public <T_ENTITY extends PersistentObject, T_ID> T_ENTITY getById(Class<T_ENTITY> clazz, T_ID id) {

        return em.find(clazz, id);
    }

    public <T_ENTITY extends PersistentObject> List<T_ENTITY> findAll(Class<T_ENTITY> clazz) {

        String q = "select o from " + clazz.getName() + " o";
        final TypedQuery<T_ENTITY> query = em.createQuery(q, clazz);

        return query.getResultList();
    }


}
