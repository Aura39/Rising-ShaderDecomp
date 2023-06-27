sampler g_Sampler0;
sampler g_Sampler1;
float2 g_offset1;
float2 g_offset2;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.xy = g_offset1.xy + texcoord.xy;
	r0.zw = r0.xy + -g_offset2.xy;
	r1 = tex2D(g_Sampler0, r0.zwzw);
	r2.xy = float2(-1, 1);
	r2 = g_offset2.xyxy * r2.xyyx + r0.xyxy;
	r0.xy = r0.xy + g_offset2.xy;
	r0 = tex2D(g_Sampler0, r0);
	r3 = tex2D(g_Sampler0, r2);
	r2 = tex2D(g_Sampler0, r2.zwzw);
	r1 = r1 + r3;
	r1 = r2 + r1;
	r0 = r0 + r1;
	r1 = tex2D(g_Sampler1, 0);
	r1.xyz = r1.xyz * 1E-07;
	o.xyz = r0.xyz * 0.25 + r1.xyz;
	o.w = r0.w;

	return o;
}
