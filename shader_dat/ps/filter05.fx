float4 g_HP_Offset : register(c185);
float4 g_MatrialColor : register(c184);
sampler g_SamplerTexture : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.x = 2;
	r0.yz = g_HP_Offset.zw * -r0.xx + texcoord.xy;
	r1 = tex2D(g_SamplerTexture, r0.yzzw);
	r1.xyz = r1.www * r1.xyz;
	r0.xy = g_HP_Offset.zw * r0.xx + texcoord.xy;
	r0 = tex2D(g_SamplerTexture, r0);
	r2.xyz = r0.www * r0.xyz;
	r2.w = r0.w;
	r3 = max(r2, r1);
	r1 = lerp(r3, r0, r3.w);
	r0.x = max(r1.x, r1.y);
	r2.x = max(r0.x, r1.z);
	r0.x = dot(r1.xyz, 0.298912);
	r0.x = r2.x + r0.x;
	r0.yz = lerp(g_MatrialColor.zw, g_MatrialColor.xy, r1.ww);
	r0.x = r0.x * 0.5 + -r0.y;
	r0.x = r0.z * r0.x;
	r0.yzw = r1.xyz + r1.xyz;
	o.w = r1.w;
	o.xyz = r0.xxx * r0.yzw;

	return o;
}
