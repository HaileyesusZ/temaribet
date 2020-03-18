package interfaces;

import java.util.HashMap;

public interface Persistable {
    static final int ACTIVE = 1;
    static final int INACTIVE = 0;
    
    Boolean persist(boolean active) throws Exception;
    void delete() throws Exception;
    void updateAttribute(String attributeName , String attributeValue ) throws Exception;
    void updateAttributes(HashMap<String, String> attributes) throws Exception;
}