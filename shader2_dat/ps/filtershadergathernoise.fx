sampler ColorTableTexture : register(s2);
sampler NoiseTexture : register(s3);
float4 g_AddColor : register(c185);
float4 g_BloomColor : register(c187);
float4 g_Brightness : register(c188);
float4 g_MulColor : register(c184);
float4 g_NoiseColor : register(c190);
float4 g_NoiseOffset : register(c189);
float4 g_Saido : register(c186);
sampler g_Sampler : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler, texcoord);
	r0.zw = r0.zx * float2(1, 0);
	r1 = r0.xxyx * float4(1, 0, 1, 0);
	r0 = tex2D(ColorTableTexture, r0.zwzw);
	r0.z = r0.x;
	r2 = tex2D(ColorTableTexture, r1);
	r1 = tex2D(ColorTableTexture, r1.zwzw);
	r0.y = r1.x;
	r0.x = r2.x;
	r0.w = dot(r0.xyz, 0.298912);
	r1.xyz = -r0.www + r0.xyz;
	r0.xyz = r1.xyz * g_Saido.xyz + r0.xyz;
	r1.xz = float2(1, 0);
	r0.w = texcoord.y * -g_AddColor.w + r1.x;
	r2.xyz = r0.www * g_AddColor.xyz;
	r0.xyz = r0.xyz * g_MulColor.xyz + r2.xyz;
	r2 = tex2D(g_Sampler, texcoord);
	r0.w = 0;
	r0 = r2 * g_BloomColor + r0;
	r0 = r0 * g_Brightness;
	r1.yw = texcoord.xy * g_NoiseOffset.xy + g_NoiseOffset.zw;
	r2 = tex2D(NoiseTexture, r1.ywzw);
	r2 = r2 * g_NoiseColor + r1.z;
	r1 = g_NoiseColor.w * r2 + r1.x;
	o = r0 * r1;

	return o;
}
