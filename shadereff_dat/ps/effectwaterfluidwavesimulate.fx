float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = float4(0.00024414062, 0, -0.00024414062, 0) + texcoord.xyxy;
	r1 = tex2D(g_Sampler1, r0);
	r0 = tex2D(g_Sampler1, r0.zwzw);
	r0.x = r0.x + r1.x;
	r1 = float4(0, 0.00024414062, 0, -0.00024414062) + texcoord.xyxy;
	r2 = tex2D(g_Sampler1, r1);
	r1 = tex2D(g_Sampler1, r1.zwzw);
	r0.x = r0.x + r2.x;
	r0.x = r1.x + r0.x;
	r1 = tex2D(g_Sampler0, texcoord);
	r0.x = r0.x * 0.5 + -r1.x;
	o.x = r0.x * g_Rate.x;
	o.yzw = 0;

	return o;
}
