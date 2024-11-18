//
//  ChatViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//

import UIKit
import MessageKit
import InputBarAccessoryView

// Previous Message and Sender structs remain the same
struct Message: MessageType {
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    var sender: SenderType
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

class ChatViewController: MessagesViewController {
    
    // MARK: - Properties
    var messages: [Message] = []
    let selfSender = Sender(senderId: "self", displayName: "Me")
    let otherSender = Sender(senderId: "other", displayName: "John")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMessageCollectionView()
        configureMessageInputBar()
        loadFirstMessages()
    }
    
    // MARK: - Configuration
    private func configureMessageCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
        messagesCollectionView.contentInset.top = 1
    }
    
    private func configureMessageInputBar() {
        messageInputBar.delegate = self
    }
    
    private func loadFirstMessages() {
        // Helper function to create messages
        func createMessage(text: String, sender: Sender, minutesAgo: Double) -> Message {
            return Message(
                messageId: UUID().uuidString,
                sentDate: Date().addingTimeInterval(-minutesAgo * 60),
                kind: .text(text),
                sender: sender
            )
        }
        
        // Create sample conversation
        let sampleMessages: [(String, Sender, Double)] = [
            ("Hey! How's it going?", otherSender, 120),
            ("Hi! I'm doing well, thanks for asking. How about you?", selfSender, 118),
            ("Pretty good! Just finished that project we discussed last week", otherSender, 115),
            ("Oh great! How did it turn out?", selfSender, 114),
            ("Really well actually! The client loved the final presentation", otherSender, 110),
            ("That's awesome to hear! 🎉", selfSender, 109),
            ("Did you use the new framework we talked about?", selfSender, 108),
            ("Yes! It made things so much easier", otherSender, 105),
            ("The documentation was really helpful", otherSender, 104),
            ("I'm glad it worked out well for you", selfSender, 100),
            ("We should catch up soon and you can show me the details", selfSender, 95),
            ("Definitely! Are you free for coffee tomorrow?", otherSender, 90),
            ("Sure! How about 10am at the usual place?", selfSender, 88),
            ("Perfect, see you then! 👍", otherSender, 85),
            ("Looking forward to it!", selfSender, 84),
            ("Oh, and don't forget to bring the project specs", otherSender, 80),
            ("Will do! I'll prepare a quick demo as well", selfSender, 75),
            ("That would be great, thanks!", otherSender, 70),
            ("No problem at all", selfSender, 65),
            ("By the way, have you seen the new software update?", otherSender, 60),
            ("Not yet, is it worth downloading?", selfSender, 58),
            ("Absolutely! Lots of new features", otherSender, 55),
            ("I'll check it out tonight then", selfSender, 50),
            ("Let me know what you think!", otherSender, 45),
            ("Will do! 👍", selfSender, 40)
        ]
        
        // Convert sample data into messages
        messages = sampleMessages.map { createMessage(text: $0.0, sender: $0.1, minutesAgo: $0.2) }
    }
}

// Rest of the extensions (MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate) remain the same
extension ChatViewController: MessagesDataSource {
    var currentSender: any MessageKit.SenderType {
        return selfSender
    }
    
   
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .systemBlue : .systemGray5
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .black
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(messageId: UUID().uuidString,
                            sentDate: Date(),
                            kind: .text(text),
                            sender: selfSender)
        
        messages.append(message)
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem(animated: true)
        inputBar.inputTextView.text = ""
    }
}
