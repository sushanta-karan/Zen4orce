<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>new_update</fullName>
        <field>Rating</field>
        <literalValue>Warm</literalValue>
        <name>new update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>test</fullName>
        <field>Rating</field>
        <literalValue>Hot</literalValue>
        <name>test</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Check for Active Account</fullName>
        <actions>
            <name>test</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Active_Account</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.BillingCountry</field>
            <operation>equals</operation>
            <value>India</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>new_update</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>Active_Account</fullName>
        <assignedTo>sushanta.karan@zen4orce-admin.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Active Account</subject>
    </tasks>
</Workflow>
