package com.iqiyi.thread;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class ScheduledExecutor {
	@SuppressWarnings("unused")
	private ScheduledExecutorService executorService=null;
	private static ScheduledExecutor scheduledExecutor = null;
	public static ScheduledExecutor getInstance(){
		if(scheduledExecutor==null){
			scheduledExecutor = new ScheduledExecutor();
		}
		return scheduledExecutor;
	}
	public ScheduledExecutor() {
		// TODO Auto-generated constructor stub
		this.executorService = Executors.newScheduledThreadPool(10);
	}
	
	public ScheduledExecutorService getExecutorService() {
		return executorService;
	}
	public void setExecutorService(ScheduledExecutorService executorService) {
		this.executorService = executorService;
	}
	public static void main(String[] args) {
		ScheduledExecutorService executorService = Executors.newScheduledThreadPool(3);
		executorService.schedule(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				System.err.println("running ..1"+System.currentTimeMillis());
			}
		}, 1,TimeUnit.SECONDS);
		executorService.schedule(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				System.err.println("running ..11"+System.currentTimeMillis());
			}
		}, 1,TimeUnit.SECONDS);
		executorService.schedule(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				System.err.println("running ..12"+System.currentTimeMillis());
			}
		}, 1,TimeUnit.SECONDS);
		executorService.schedule(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				System.err.println("running ..2");
			}
		}, 10,TimeUnit.SECONDS);
		executorService.schedule(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				System.err.println("running ..3");
			}
		}, 20,TimeUnit.SECONDS);
		executorService.schedule(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				System.err.println("running ..4");
			}
		}, 30,TimeUnit.SECONDS);
		
	}
}
