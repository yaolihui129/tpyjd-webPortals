package cn.pacificimmi.common.utils;

import java.net.InetAddress;

import javax.servlet.http.HttpServletRequest;

public class CheckIP {
    public static InetAddress IA=null;
        public static String checkip(){

            try {
                IA=InetAddress.getLocalHost();
                String localname=IA.getHostName();
                String localip=IA.getHostAddress();

                return localip;
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                return "获取IP失败";
            }
        }

        public static String getIpAddr(HttpServletRequest request) {
        //HttpServletRequest request=null;
         String ipAddress = null;
         //ipAddress = this.getRequest().getRemoteAddr();
             ipAddress = request.getHeader("x-forwarded-for");
             if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
              ipAddress = request.getHeader("Proxy-Client-IP");
             }
             if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                 ipAddress = request.getHeader("WL-Proxy-Client-IP");
             }
             if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
              ipAddress = request.getRemoteAddr();
              if(ipAddress.equals("127.0.0.1")){
               //根据网卡取本机配置的IP
               InetAddress inet=null;
                try {
                 inet = InetAddress.getLocalHost();
                } catch (Exception e) {
                 e.printStackTrace();
                }
            ipAddress= inet.getHostAddress();
              }

             }

             //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
             if(ipAddress!=null && ipAddress.length()>15){ //"***.***.***.***".length() = 15
                 if(ipAddress.indexOf(",")>0){
                     ipAddress = ipAddress.substring(0,ipAddress.indexOf(","));
                 }
             }

         return ipAddress;
      }
}
