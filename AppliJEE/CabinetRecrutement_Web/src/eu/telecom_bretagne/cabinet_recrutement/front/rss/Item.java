//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.3-hudson-jaxb-ri-2.2.3-3- 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2011.10.13 at 04:45:00 PM CEST 
//

package eu.telecom_bretagne.cabinet_recrutement.front.rss;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for anonymous complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element ref="{}title"/>
 *         &lt;element ref="{}link"/>
 *         &lt;element ref="{}description"/>
 *         &lt;element ref="{}pubDate"/>
 *         &lt;element ref="{}enclosure" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder =
{ "title", "link", "description", "pubDate", "enclosure" })
@XmlRootElement(name = "item")
public class Item
{
	//-----------------------------------------------------------------------------
	@XmlElement(required = true)
	protected String title;
	@XmlElement(required = true)
	@XmlSchemaType(name = "anyURI")
	protected String link;
	@XmlElement(required = true)
	protected String description;
	@XmlElement(required = true)
	protected String pubDate;
	protected Enclosure enclosure;
	//-----------------------------------------------------------------------------
	/**
	 * Gets the value of the title property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getTitle()
	{
		return title;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Sets the value of the title property.
	 * 
	 * @param value
	 *          allowed object is {@link String }
	 * 
	 */
	public void setTitle(String value)
	{
		this.title = value;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Gets the value of the link property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getLink()
	{
		return link;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Sets the value of the link property.
	 * 
	 * @param value
	 *          allowed object is {@link String }
	 * 
	 */
	public void setLink(String value)
	{
		this.link = value;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Gets the value of the description property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDescription()
	{
		return description;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Sets the value of the description property.
	 * 
	 * @param value
	 *          allowed object is {@link String }
	 * 
	 */
	public void setDescription(String value)
	{
		this.description = value;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Gets the value of the pubDate property.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getPubDate()
	{
		return pubDate;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Sets the value of the pubDate property.
	 * 
	 * @param value
	 *          allowed object is {@link String }
	 * 
	 */
	public void setPubDate(String value)
	{
		this.pubDate = value;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Gets the value of the enclosure property.
	 * 
	 * @return possible object is {@link Enclosure }
	 * 
	 */
	public Enclosure getEnclosure()
	{
		return enclosure;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Sets the value of the enclosure property.
	 * 
	 * @param value
	 *          allowed object is {@link Enclosure }
	 * 
	 */
	public void setEnclosure(Enclosure value)
	{
		this.enclosure = value;
	}
	//-----------------------------------------------------------------------------
}
