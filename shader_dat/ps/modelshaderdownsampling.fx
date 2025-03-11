sampler g_Sampler0 : register(s0);
float2 g_offset1 : register(c184);
float2 g_offset2 : register(c185);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = g_offset1.xyxy + texcoord.xyxy;
	r1.xy = float2(-0.5, 0.5);
	r2 = g_offset2.xyxy * r1.xxxy + r0.zwzw;
	r0 = g_offset2.xyxy * r1.yxyy + r0;
	r1 = tex2D(g_Sampler0, r2);
	r2 = tex2D(g_Sampler0, r2.zwzw);
	r1 = r1 + r2;
	r2 = tex2D(g_Sampler0, r0);
	r0 = tex2D(g_Sampler0, r0.zwzw);
	r1 = r1 + r2;
	r0 = r0 + r1;
	o = r0 * 0.25;

	return o;
}
