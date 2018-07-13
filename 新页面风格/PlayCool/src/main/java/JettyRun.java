/**
 * Copyright©2014 www.jshuabo.com. all rights reserved.
 *
 * @Title: JettyRun.java
 * @Prject: memory-webapp
 * @Package: 
 * @author: lianghe.yuan
 * @date: May 24, 2014 9:37:43 PM
 * @version: 
 * @Description: 
 */

import org.apache.log4j.PropertyConfigurator;
import org.mortbay.jetty.Connector;
import org.mortbay.jetty.Server;
import org.mortbay.jetty.nio.SelectChannelConnector;
import org.mortbay.jetty.webapp.WebAppContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassName: JettyRun
 * @Description: 项目启动类
 * @author: lianghe.yuan
 * @date: May 24, 2014 9:37:43 PM
 */
public class JettyRun {
    private static final Logger logger = LoggerFactory.getLogger(JettyRun.class);
    
    /** 端口 */
    private int port = 8080;
    /** 应用名 */
    private String contextName = "template_admin_mysql";
    /** webapp路径 */
    private String contextPath = "src/main/webapp";
    
    private static String[] profiles = {"development", "test", "production"};

    public void start() throws Exception {
        PropertyConfigurator.configureAndWatch("log4j_" + getProfile() + ".xml", 10000);
        
        System.setProperty("profiles.active", getProfile());

        Long t1 = System.currentTimeMillis();

        Server server = new Server();
        Connector connector = new SelectChannelConnector();
        connector.setPort(port);

        WebAppContext context = new WebAppContext(contextPath, "/" + contextName);
        server.setConnectors(new Connector[] {connector});
        server.setHandler(context);

        logger.info("web application:[{}] begin starting...耗时[{}ms]", contextName);

        server.start();

        Long t2 = System.currentTimeMillis();
        logger.info("web application:[{}] running... 耗时[{}ms]", new Object[] {contextName, t2 - t1});
    }
    
    public static String getProfile() {
        return profiles[0];
    }

    public static void main(String[] args) throws Exception {
        new JettyRun().start();
    }

}