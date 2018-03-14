package com.jk.gs.utils.user;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class ThreadPool {

    //缓存线程池
    static ExecutorService cachedThreadPool = Executors.newCachedThreadPool();

    //定长线程池
    static ExecutorService fixedThreadPool = Executors.newFixedThreadPool(3);

    //定时定长线程池
    static ScheduledExecutorService scheduledThreadPool = Executors.newScheduledThreadPool(5);

    //单列线程池
    static ExecutorService singleThreadExecutor = Executors.newSingleThreadExecutor();

    /**
     * 缓存线程池
     * @param runnable
     */
    public static void executeCachedThread(Runnable runnable){
        cachedThreadPool.execute(runnable);
    }

    /**
     * 定长线程池
     * @param runnable
     */
    public static void executeFixedThread(Runnable runnable){
        fixedThreadPool.execute(runnable);
    }

    /**
     * 定长定时线程池（单位毫秒）
     * @param runnable
     * @param time
     */
    public static void executeScheduledThread(Runnable runnable,long time){
        scheduledThreadPool.schedule(runnable,time, TimeUnit.MILLISECONDS);
    }

    /**
     * 单例线程池（有顺序执行）
     * @param runnable
     */
    public static void executeSingleThreadExecutor(Runnable runnable){
        singleThreadExecutor.execute(runnable);
    }




}
