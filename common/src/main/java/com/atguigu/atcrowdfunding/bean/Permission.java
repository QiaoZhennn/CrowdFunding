package com.atguigu.atcrowdfunding.bean;

import java.util.ArrayList;
import java.util.List;

public class Permission {

    private Integer id;
    private Integer pid;
    private String name;
    private String icon;
    private String url;
    //open属性用来设置zTree默认是否展开，true为展开，前端自动获取该javaBean的"open"属性，并做处理。
    private boolean open=true;
    //checked属性用来设置zTree是否被选中，前端需要设置setting中check:enabled，方可生效。
    private boolean checked=false;

    @Override
    public String toString() {
        return "Permission{" +
                "id=" + id +
                ", pid=" + pid +
                ", name='" + name + '\'' +
                ", open=" + open +
                ", children=" + children +
                '}';
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    private List<Permission> children=new ArrayList<Permission>();

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public List<Permission> getChildren() {
        return children;
    }

    public void setChildren(List<Permission> children) {
        this.children = children;
    }
}
