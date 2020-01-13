module Pantograph
  module Actions
    class JiraAction < Action
      def self.run(params)
        Actions.verify_gem!('jira-ruby')
        require 'jira-ruby'

        client = JIRA::Client.new(
          {
            site: params[:url],
            context_path: params[:context_path],
            auth_type: :basic,
            username: params[:username],
            password: params[:password]
          }
        )

        issue   = client.Issue.find(params[:ticket_id])
        comment = issue.comments.build
        comment.save({ 'body' => params[:comment_text] })
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Leave a comment on JIRA tickets'
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(
            key: :url,
            env_name: 'JIRA_SITE',
            description: 'URL for Jira instance',
            optional: false
          ),
          PantographCore::ConfigItem.new(
            key: :context_path,
            env_name: 'JIRA_CONTEXT_PATH',
            description: "Appends to the url (ex: \"/jira\")",
            optional: true,
            default_value: ''
          ),
          PantographCore::ConfigItem.new(
            key: :username,
            env_name: 'JIRA_USERNAME',
            description: 'Username for JIRA instance',
            optional: false
          ),
          PantographCore::ConfigItem.new(
            key: :password,
            env_name: 'JIRA_PASSWORD',
            description: 'Password for Jira',
            sensitive: true,
            optional: false
          ),
          PantographCore::ConfigItem.new(
            key: :ticket_id,
            env_name: 'JIRA_TICKET_ID',
            description: 'Ticket ID for Jira, i.e. APP-123',
            optional: false
          ),
          PantographCore::ConfigItem.new(
            key: :comment_text,
            env_name: 'JIRA_COMMENT_TEXT',
            description: 'Text to add to the ticket as a comment',
            optional: false
          )
        ]
      end

      def self.return_value
      end

      def self.authors
        ['iAmChrisTruman']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'jira(
            url: "https://bugs.yourdomain.com",
            username: "Your username",
            password: "Your password",
            ticket_id: "Ticket ID, i.e. IOS-123",
            comment_text: "Text to post as a comment"
          )',
          'jira(
            url: "https://yourserverdomain.com",
            context_path: "/jira",
            username: "Your username",
            password: "Your password",
            ticket_id: "Ticket ID, i.e. IOS-123",
            comment_text: "Text to post as a comment"
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
