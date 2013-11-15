enable 'sessions'
get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/create_key' do
  user = User.create(name: params[:name], email: params[:email], password: params[:password])
  session[:id] = user.id
  rs1 = SecureRandom.hex
  rs2 = SecureRandom.hex
  rs3 = SecureRandom.hex
  rs4 = SecureRandom.hex
  rs5 = SecureRandom.hex

  Key.create(user_id: session[:id], token: rs1)
  Key.create(user_id: session[:id], token: rs2)
  Key.create(user_id: session[:id], token: rs3)
  Key.create(user_id: session[:id], token: rs4)
  Key.create(user_id: session[:id], token: rs5)

  @qr1 = RQRCode::QRCode.new('/chat/' + rs1.to_s, :size => 5, :level => :h )
  @qr2 = RQRCode::QRCode.new('/chat/' + rs2.to_s, :size => 5, :level => :h )
  @qr3 = RQRCode::QRCode.new('/chat/' + rs3.to_s, :size => 5, :level => :h )
  @qr4 = RQRCode::QRCode.new('/chat/' + rs4.to_s, :size => 5, :level => :h )
  @qr5 = RQRCode::QRCode.new('/chat/' + rs5.to_s, :size => 5, :level => :h )
  erb :key
end

post '/key_attr' do

  erb :key
end

get '/chat/:token' do
  session[:token] = params[:token]
  p session[:token]
  erb :chat
end

post '/chat_input/:token' do
  key_id = Key.find_by_token(params[:token])
  Chat.create(phrase: params[:phrase], user: session[:id], key: key_id)
  erb :chat
end