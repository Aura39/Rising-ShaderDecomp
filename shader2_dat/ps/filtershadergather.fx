sampler ColorTableTexture;
float4 g_AddColor;
float4 g_BloomColor;
float4 g_Brightness;
float4 g_MulColor;
float4 g_Saido;
sampler g_Sampler;

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
	r1.x = 1;
	r0.w = texcoord.y * -g_AddColor.w + r1.x;
	r1.xyz = r0.www * g_AddColor.xyz;
	r0.xyz = r0.xyz * g_MulColor.xyz + r1.xyz;
	r1 = tex2D(g_Sampler, texcoord);
	r0.w = 0;
	r0 = r1 * g_BloomColor + r0;
	o = r0 * g_Brightness;

	return o;
}
