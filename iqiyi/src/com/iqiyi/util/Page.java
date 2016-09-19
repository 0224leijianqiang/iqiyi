package com.iqiyi.util;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: eric
 * Date: 15-8-22
 * Time: 下午1:56
 * To change this template use File | Settings | File Templates.
 */
public class Page<T> {
    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getStart() {
        return (current-1)*count;
    }


    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getPages() {
        return (int) Math.ceil(Double.valueOf(total)/Double.valueOf(count));
    }


    public List<T> getResult() {
        return result;
    }

    public void setResult(List<T> result) {
        this.result = result;
    }



    public int getCurrent() {
        return current;
    }

    public void setCurrent(int current) {
        this.current = current;
    }

    private int current;
    private List<T> result;
    private int total;
    private int count=15;
}
